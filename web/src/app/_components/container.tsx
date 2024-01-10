import {ReactNode} from "react";
import clsx from "clsx";

type Props = { children: ReactNode, className?: string }

const Container = ({children, className}: Props) =>
    <div className={clsx("bg-white border border-gray-100 rounded-lg p-4", className)}>
        {children}
    </div>

const Lg = (props: Props) => <Container className={clsx(props.children, "sm:col-span-2")}>
    {props.children}
</Container>

const Title = ({children}: { children: ReactNode }) => <h2 className={"font-bold text-2xl"}>{children}</h2>

export default Object.assign(Container, {
    Lg,
    Title,
})
