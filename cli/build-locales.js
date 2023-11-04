const p = require("path");
const { PhraseyLocaleBuilder } = require("@zyrouge/phrasey-locales-builder");
const { writeFile } = require("fs/promises");

const generatedFilePath = p.join(__dirname, "../lib/locale.g.dart");

const start = async () => {
    const locales = await PhraseyLocaleBuilder.build({
        displayLocaleCode: "en",
    });
    const idExceptions = {
        is: "is_",
        as: "as_",
    };
    /**
     * @type {string[]}
     */
    const mapped = [];
    /**
     * @type {string[]}
     */
    const props = [];
    locales.forEach((x) => {
        let id = x.code.replaceAll("-", "_");
        id = idExceptions[id] ?? id;
        mapped.push(`    '${x.code}': ${id},`);
        props.push(
            `  static const Locale ${id} = Locale('${x.display}', '${x.native}', '${x.code}');`
        );
    });
    const content = `
// ignore_for_file: constant_identifier_names, eol_at_end_of_file
// Generated file. Do not edit.

part of 'locale.dart';

class LocalesRepository {
  static const Map<String, Locale> all = <String, Locale>{
${mapped.join("\n")}
  };

${props.join("\n")}
}
    `;
    await writeFile(generatedFilePath, content);
};

start();
