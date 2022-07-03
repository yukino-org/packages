const { spawnSync: _spawnSync } = require("child_process");
const { writeFile, writeFileSync } = require("fs");
const path = require("path");

const github = "https://github.com/yukino-org/packages";

const branches = {
    dart_devx: () => gDartDoc("dart_devx"),
    dart_tenka_dev_tools: () => gDartDoc("dart_tenka_dev_tools"),
    dart_tenka_runtime: () => gDartDoc("dart_tenka_runtime"),
    dart_tenka: () => gDartDoc("dart_tenka"),
    dart_utilx: () => gDartDoc("dart_utilx"),
};

const outputDocsDir = path.join(__dirname, "../docs");

const generateIndexHtml = () => {
    const title = `Documentation - Yukino Packages`;
    const output = path.join(outputDocsDir, "index.html");

    writeFileSync(
        output,
        `
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${title}</title>

        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic"
        />
    </head>
    <body>
        <h1>${title}</h1>
        <br />
        <hr />
        <br />
        <ul>
            ${Object.keys(branches).map(
                (x) => `<li><a href="./${x[1]}">${x[0]}</a></li>`
            )}
        </ul>
    </body>
    <style>
        :root {
            --body-padding-x: 2rem;
            --body-padding-y: 1rem;
        }

        @media (min-width: 1280px) {
            :root {
                --body-padding-x: 10rem;
                --body-padding-y: 2rem;
            }
        }

        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: "Roboto", sans-serif;
            padding: var(--body-padding-y) var(--body-padding-x);
        }

        h1 {
            font-size: 1.5rem;
        }

        hr {
            opacity: 0.2;
        }

        ul {
            padding: 0.5rem 1.5rem;
        }

        a {
            color: #6366f1;
            text-decoration: none;
        }

        a:hover {
            color: #3437dd;
        }
    </style>
</html>
    `.trim()
    );

    console.log(`main -> ${output}`);
};

const gDartDoc = (branch) => {
    const dir = `${__dirname}/.cloned/${branch}`;

    // Clone repo
    spawnSync("git", ["clone", github, "-b", branch, dir]);

    // Install deps
    spawnSync("dart", ["pub", "get"], {
        cwd: dir,
        shell: true,
    });

    // Generate docs
    const output = path.join(outputDocsDir, branch);
    spawnSync("dart", ["doc", "-o", output], {
        cwd: dir,
        shell: true,
    });

    console.log(`${branch} -> ${output}`);
};

const generateDocs = () => {
    for (const x of Object.values(branches)) {
        x();
    }
    generateIndexHtml();
};

module.exports = { generateDocs };

/**
 * @param {Parameters<typeof spawnSync>} args
 */
function spawnSync(...args) {
    const { status, output } = _spawnSync(...args);
    if (status !== 0) {
        throw Error(
            `
Command Error: ${JSON.stringify(args)}
Status: ${status}
Output:
${output}
        `.trim()
        );
    }
}
