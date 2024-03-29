import Image from 'next/image'
import Link from "next/link";
import Container from "@/app/_components/container";
import {Hosts} from "@/app/_components/hosts";


const Title = () => <Container>
    <div className={"h-32 flex md:max-w-xl"}>
        <h1 className={"text-3xl md:text-4xl font-bold my-auto mx-auto"}>I&apos;m <span className={"bg-orange-600 text-white px-[0.2em]"} >10.22.0.1</span></h1>
    </div>
</Container>

const SelfIntroduction = () => <Container>
    <div className={"h-32 flex md:max-w-xl"}>
        <Image className={"my-auto rounded-full"} src={"https://smdr.io/icon.jpeg"} alt={""} height={120} width={120} />
        <p className={"my-auto text-lg px-2 font-medium"}>私は rabbit_house です</p>
    </div>
</Container>

const About = () => <Container className={"sm:col-span-2"}>
    <div>
        <h2 className={"font-bold text-2xl"}>このホストの概要</h2>
        <ul className={"list-disc list-inside"}>
            <li>
                さくらのVPS上に構築されています
            </li>
            <li>tinc VPN Root Nodeです（予定）</li>
            <li>sizumitaのみが利用できるVPNがstrongSwanによってホスティングされています。</li>
        </ul>
    </div>
</Container>

const Services = () => <Container className={"sm:col-span-2 my-a"}>
    <div className={"h-32"}>
        <h2 className={"font-bold text-2xl"}>このホストで稼働しているサービス</h2>
        <ul className={"list-disc list-inside"}>
            <li>Web App(Next.js Static Export + Nginx)(HTTP, TCP 80)</li>
            <li><Link href={"/qr"}>QRコード印字サービス</Link></li>
        </ul>
    </div>
</Container>

const Webring = () => <Container className={"flex"}>
    <div className={"text-center space-x-2 text-4xl my-auto mx-auto"}>
        <Link href={"http://10.22.0.1/cgi-bin/webring.cgi?ip=10.22.0.1&to=before2"}>&#x23EA;</Link>
        <Link href={"http://10.22.0.1/cgi-bin/webring.cgi?ip=10.22.0.1&to=before"}>&#x25C0;&#xFE0F;</Link>
        <Link href={"http://10.22.0.1/cgi-bin/webring.cgi?ip=10.22.0.1&to=after"}>&#x25B6;&#xFE0F;</Link>
        <Link href={"http://10.22.0.1/cgi-bin/webring.cgi?ip=10.22.0.1&to=after2"}>&#x23E9;</Link>
    </div>
</Container>

export default function Home() {
  return (
      <main className={"grid grid-cols-1 sm:grid-cols-2  lg:grid-cols-4 gap-4 border-amber-600"}>
          <Title/>
          <SelfIntroduction/>
          <About/>
          <Services/>
          <Hosts/>
          <Webring/>
      </main>
  )
}
