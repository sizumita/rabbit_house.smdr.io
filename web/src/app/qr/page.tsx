"use client"
import Container from "@/app/_components/container";
import {FormEvent, useState} from "react";

const QRCodeCreator = () => {
    const [status, setStatus] = useState("入力してね")
    async function onSubmit(event: FormEvent<HTMLFormElement>) {
        event.preventDefault()
        const formData = new FormData(event.currentTarget)
        const url = formData.get("url")
        if (url === null) return
        const response = await fetch(`/cgi-bin/print_qr.cgi?url=${url}`, {method: "POST"})
        if (response.ok) {
            setStatus("完了")
        } else {
            setStatus("エラーが発生しました")
        }
    }

    return <Container.Lg>
        <Container.Title>QRコード生成</Container.Title>
        <form onSubmit={onSubmit}>
            <div className="">
                <label htmlFor="username" className="block text-sm font-medium leading-6 text-gray-900">
                    URL
                </label>
                <div className="mt-2">
                    <div
                        className="flex rounded-md shadow-sm ring-1 ring-inset ring-gray-300 focus-within:ring-2 focus-within:ring-inset focus-within:ring-orange-600 sm:max-w-md">
                        <input
                            type="text"
                            name="url"
                            id="url"
                            className="block flex-1 border-0 bg-transparent py-1.5 pl-1 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6"
                            placeholder="https://scrapbox.com/"
                        />
                    </div>
                    <p>Status: {status}</p>
                </div>
            </div>
            <div className="mt-6 flex items-center justify-end gap-x-6">
                <button
                    type="submit"
                    className="rounded-md bg-orange-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-orange-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-orange-600"
                >
                    Save
                </button>
            </div>
        </form>
    </Container.Lg>
}

export default function QR() {
    return <main className={"grid grid-cols-1 sm:grid-cols-2  lg:grid-cols-4 gap-4 border-amber-600"}>
        <QRCodeCreator />
    </main>
}
