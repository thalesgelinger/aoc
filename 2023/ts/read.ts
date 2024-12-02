import fs from "fs"
export function readLines(path: string): string[] {
    return fs.readFileSync(path).toString().split("\n").filter(v => !!v)
}
