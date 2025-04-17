import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

public class PapyChecker {

    // Add more Papyrus keywords as needed
    private static final Set<String> PKEYWORDS = Set.of(
        "auto", "bool", "else", "elseif", "endevent", "endfunction", "endif",
        "endproperty", "endstate", "endwhile", "event", "false", "float",
        "function", "gotostate", "if", "int", "none", "parent", "property",
        "return", "scriptname", "state", "string", "true", "while"
    );

    private static final Pattern BARE_VAR_LINE = Pattern.compile(
        "^\\s*([a-zA-Z_][a-zA0-9_]*)\\s*(;.*)?$", 
        Pattern.CASE_INSENSITIVE
    );


    public static void main(String[] args) throws IOException {
        if (args.length != 1) {
            System.out.println("Usage: java PapyChecker <folder>");
            System.out.println(String.format("args.length: %d", args.length));
            for (int i = 0; i < args.length; i++) {
                System.out.println(String.format("args[i]: '%s'", i, args[i]));
            }
            return;
        }

        Path folder = Paths.get(args[0]);

        if (!Files.exists(folder) || !Files.isDirectory(folder)) {
            System.out.println("Error: Folder not found or is not a directory.");
            return;
        }

        System.out.println("Scanning folder: " + folder.toAbsolutePath());

        Files.walk(folder)
            .filter(path -> path.toString().toLowerCase().endsWith(".psc"))
            .forEach(PapyChecker::checkFile);
    }

    private static void checkFile(Path file) {
        try {
            List<String> lines = Files.readAllLines(file);
            boolean reported = false;

            for (int i = 0; i < lines.size(); i++) {
                String line = lines.get(i).trim();

                if (line.isEmpty() || line.startsWith(";")) continue;

                Matcher m = BARE_VAR_LINE.matcher(line);
                if (m.matches()) {
                    String identifier = m.group(1).toLowerCase();  // Convert the identifier to lowercase
                    if (!PKEYWORDS.contains(identifier)) {  // Check against the lowercase keywords
                        if (!reported) {
                            System.out.println("File: " + file.toAbsolutePath());
                            reported = true;
                        }
                        System.out.printf("  Line %d: possible bare variable '%s'%n", i + 1, m.group(1));
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading file: " + file + " - " + e.getMessage());
        }
    }
}
