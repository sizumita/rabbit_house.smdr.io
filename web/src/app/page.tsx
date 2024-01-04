import Image from 'next/image'
import {ReactNode} from "react";
import clsx from "clsx";

const Container = ({children, className}: {children: ReactNode, className?: string}) =>
    <div className={clsx("bg-white border border-gray-100 rounded-lg p-4", className)}>
    {children}
</div>

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

const Services = () => <Container className={"sm:col-span-2"}>
    <div className={"h-32"}>
        <h2 className={"font-bold text-2xl"}>このホストで稼働しているサービス</h2>
        <ul className={"list-disc list-inside"}>
            <li>Web App(Next.js Static Export + Nginx)(HTTP, TCP 80)</li>
        </ul>
    </div>
</Container>

export default function Home() {
  return (
      <main className="min-h-screen bg-gray-200 p-2">
          <div className={"grid grid-cols-1 sm:grid-cols-2  lg:grid-cols-4 gap-4 border-amber-600"}>
              <Title />
              <SelfIntroduction />
              <About />
              <Services />
          </div>
    </main>
  )
}
