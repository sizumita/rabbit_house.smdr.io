import {useEffect, useState} from "react";

export type Host = {
    ip: string
    up: boolean
}

export function useHosts(): Host[] {
    const [hosts, setHosts] = useState<Host[]>([])

    useEffect(() => {
        process.env.NODE_ENV === "production" ? (fetchHosts().then(setHosts).catch(console.error)) : setHosts([{
            ip: "10.0.0.1",
            up: true
        }])
    }, [])

    return hosts
}

async function fetchHosts() {
    const response = await fetch("/cdn-cgi/hosts.cgi")
    return response.ok ? (await response.json() as Host[]) : []
}
