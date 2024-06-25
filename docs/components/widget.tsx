import {useTheme} from "nextra-theme-docs";

interface Props {
    name: string;
    variant?: string;
    query: Record<string, string>;
}

export function Widget({name, variant = 'default', query}: Props) {
    const {resolvedTheme} = useTheme();
    query['theme'] = `zinc-${resolvedTheme}`;

    const url = process.env['NEXT_PUBLIC_DEMO_URL'];

    return (
        <iframe
            className="w-full border rounded"
            src={`${url}/${name}/${variant}?${new URLSearchParams(query).toString()}`}
        />
    );
}
