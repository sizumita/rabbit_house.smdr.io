import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'
import clsx from "clsx";

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: '10.22.0.1',
  description: 'Rabbit Houseへようこそ！',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="ja">
      <body className={clsx(inter.className, "min-h-screen bg-gray-200 p-2")}>{children}</body>
    </html>
  )
}
