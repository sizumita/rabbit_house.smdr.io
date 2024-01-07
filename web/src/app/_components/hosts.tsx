"use client"
import Container from "@/app/_components/container";
import {useHosts} from "@/hooks/useHosts";
import Link from "next/link";

export const Hosts = () => {
    const hosts = useHosts()

    return <Container className={"sm:col-span-2"}>
        <div className={"min-h-32"}>
            <h2 className={"font-bold text-2xl mb-2"}>GSNetに存在しているノードの状態</h2>
            <table className={"text-lg table-fixed w-full border-collapse border border-orange-500 rounded-md"}>
                <thead>
                <tr>
                    <th className={"border border-orange-500"}>IP</th>
                    <th className={"border border-orange-500"}>状態</th>
                </tr>
                </thead>
                <tbody>
                {hosts.map((host, i) => <tr key={i}>
                    <td className={"border border-orange-500 px-2"}>
                        <Link href={`http://${host.ip}`} className={"font-bold"}>
                            {host.ip}
                        </Link>
                    </td>
                    <td className={"border border-orange-500 px-2"}>{host.up ? "起動" : "停止"}</td>
                </tr>)}
                </tbody>
            </table>
        </div>
    </Container>
}
