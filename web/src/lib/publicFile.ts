
import config from "../../next.config.js";

export function publicFile(filename: string): string {
    let base = "";
    if (config.basePath) {
        base = config.basePath;
    } else if (config.assetPrefix) {
        base = config.assetPrefix;
    }

    if (base !== "") {
        return `${base}/${filename}`;
    } else {
        return filename;
    }
}
