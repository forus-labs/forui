import {useTheme} from "nextra-theme-docs";

interface Props {
    query: Record<string, string>;
}

export function Widget({query}: Props) {
    const {resolvedTheme} = useTheme();
    query['theme'] = resolvedTheme;

    const url = process.env['NEXT_PUBLIC_DEMO_URL'];

    return <iframe
        src={`${url}?${new URLSearchParams(query).toString()}`}
        width={0}
        height={0}
    />;
}
