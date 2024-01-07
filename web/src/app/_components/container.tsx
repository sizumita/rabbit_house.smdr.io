import {ReactNode} from "react";
import clsx from "clsx";

const Container = ({children, className}: {children: ReactNode, className?: string}) =>
    <div className={clsx("bg-white border border-gray-100 rounded-lg p-4", className)}>
    {children}
</div>

export default Container
