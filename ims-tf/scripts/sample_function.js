export function main(args) {
    return {
        // A temporary measure until the function runtime supports parsing arguments.
        message: "hello " + JSON.parse(args).body.message
    };
}
