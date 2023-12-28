UNIQUE_ID=$1
echo "started" >> /var/log/gpt.log
TMPDIR="/tmp"
TMP_FILE="$(mktemp -d gpt-XXXXX)"
API_KEY=$(cat /root/rabbit_house.smdr.io/secrets/OPENAI_API_KEY.txt)

if [ ! -e /var/spool/asterisk/recordings/call-$UNIQUE_ID.wav ]; then
  echo "File not found"
  exit 1
fi

TEXT="$(curl -sL https://api.openai.com/v1/audio/transcriptions \
          -H "Authorization: Bearer $API_KEY" \
          -H "Content-Type: multipart/form-data" \
          -F language="ja" \
          -F response_format="text" \
          -F model="whisper-1" \
          -F file="@/var/spool/asterisk/recordings/call-$UNIQUE_ID.wav")"

echo $TMP_FILE
cat > $TMP_FILE/data.md <<'EOF'
---
header-includes:
    - \usepackage{geometry}
    - \geometry{a4paper, top=3mm, left=3mm, right=3mm,bottom=3mm}
---

\pagenumbering{gobble}
\fontsize{30pt}{34pt}\selectfont
EOF
echo "> $(echo $TEXT)" >> $TMP_FILE/data.md
echo "" >> $TMP_FILE/data.md

RESPONSE_TEXT="$(curl -sL https://api.openai.com/v1/chat/completions \
          -H "Authorization: Bearer $API_KEY" \
          -H "Content-Type: application/json" \
          -d '{
              "model": "gpt-4",
              "messages": [
                  {
                      "role":"user",
                      "content": "'"$TEXT"'"
                  }
              ],
              "temperature": 1.0,
              "max_tokens": 1000
          }' | jq '.choices[].message.content' |
              sed -e 's/^"\|"$//g' -e 's/\\n/\n/g')"

echo $RESPONSE_TEXT >> $TMP_FILE/data.md

pandoc $TMP_FILE/data.md -o $TMP_FILE/data.pdf  -V documentclass=ltjarticle --pdf-engine=lualatex
lp -d sumidora $TMP_FILE/data.pdf -o media=a4
rm -rf $TMP_FILE
