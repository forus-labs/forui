import {useTheme} from "nextra-theme-docs";

interface Props {
    name: string;
    variant?: string;
    query: Record<string, string>;
}

export function Widget({name, variant = 'default', query}: Props) {
    const {resolvedTheme} = useTheme();
    query['theme'] = resolvedTheme;

    const url = process.env['NEXT_PUBLIC_DEMO_URL'];

    return (
        <iframe
            src={`${url}/${name}/${variant}?${new URLSearchParams(query).toString()}`}
            width={0}
            height={0}
        />
    );
}
