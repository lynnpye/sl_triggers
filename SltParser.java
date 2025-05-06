import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.*;

public class SltParser {

    public static class SltSection {
        public String name;
        public String group;
        public List<String> desc = new ArrayList<>();
        public List<String> args = new ArrayList<>();
        public List<String> argsmore = new ArrayList<>();
        public List<String> samples = new ArrayList<>();
        public List<String> results = new ArrayList<>();

        String getGroup() {
            if (group == null) {
                System.out.println("group is null for name: " + name);
            }
            return group;
        }

        String getName() {
            if (name == null) {
                System.out.println("name is null shitfuckdamn");
            }
            return name;
        }

    }

    public static List<SltSection> parseSltSections(String filename) throws IOException {
        List<SltSection> sections = new ArrayList<>();

        List<String> lines = Files.readAllLines(Paths.get(filename));
        SltSection current = null;

        for (String line : lines) {
            line = line.trim();

            if (line.startsWith("; slt")) {
                if (line.startsWith("; sltname")) {
                    // Save previous section
                    if (current != null) {
                        sections.add(current);
                    }
                    // Start new section
                    current = new SltSection();
                    current.name = line.substring("; sltname".length()).trim();
                } else if (current != null) {
                    if (line.startsWith("; sltgrup")) {
                        current.group = line.substring("; sltgrup".length()).trim();
                    } else if (line.startsWith("; sltdesc")) {
                        current.desc.add(line.substring("; sltdesc".length()).trim());
                    } else if (line.startsWith("; sltargs")) {
                        if (line.startsWith("; sltargsmore")) {
                            current.argsmore.add(line.substring("; sltargsmore".length()).trim());
                        } else {
                            current.args.add(line.substring("; sltargs".length()).trim());
                        }
                    } else if (line.startsWith("; sltsamp")) {
                        current.samples.add(line.substring("; sltsamp".length()).trim());
                    } else if (line.startsWith("; sltrslt")) {
                        current.results.add(line.substring("; sltrslt".length()).trim());
                    }
                }
            } else {
                // end of section
                if (current != null) {
                    sections.add(current);
                    current = null;
                }
            }
        }

        // Add last section if file ends with one
        if (current != null) {
            sections.add(current);
        }

        return sections;
    }

    public static Map<String, List<SltSection>> sortSltSections(List<SltSection> sltlist) {
        return sltlist.stream()
            .collect(Collectors.groupingBy(
                SltSection::getGroup,
                TreeMap::new, // Use TreeMap to maintain sorted order of group keys
                Collectors.collectingAndThen(
                    Collectors.toList(),
                    list -> {
                        list.sort(Comparator.comparing(SltSection::getName));
                        return list;
                    }
                )
            ));
    }

    public static void exportMD(
        Map<String, List<SltSection>> sortedslts,
        Map<String, List<SltSection>> sortedsexlabs,
        Map<String, List<SltSection>> sortedcores) {
/*
        sortedGroupedAndSorted.forEach((group, sectionsInGroup) -> {
            //System.out.println("# " + group);
            System.out.println(String.format("%s:\n==============\n", group));
            sectionsInGroup.forEach(section -> {
                System.out.println(Tmpl02(section));
            });
        });
        */
       StringBuilder sb = new StringBuilder();

        sb.append("# Function Libraries\nSL Triggers ships with three \"function libraries\". Function libraries allow functions to be overridden to change or enhance functionality contextually. For example, util_waitforkbd will return at the end of a SexLab scene when SexLab is present, in addition to when one of the selected keys is present, as SexLab overrides the behavior.\n\nAs a result, some functions will appear twice. If it is in the SexLab section it is an override to the baseline functionality in the SLT library.\n\n***\n\n# SLT Function Library (base functionality)\n\n***\n\n");

        sortedslts.forEach((group, sectionsInGroup) -> {
            sb.append(String.format("# %s\n\n", group ));
            //sb.append(String.format("\n%s:\n==============\n\n", group));
            sectionsInGroup.forEach(section -> {
                sb.append(Tmpl01(section));
            });
        });

        sb.append("\n\n***\n\n# SexLab Function Library (only functional if SexLab is present)\n\n***\n\n");

        sortedsexlabs.forEach((group, sectionsInGroup) -> {
            sb.append(String.format("# %s\n\n", group ));
            //sb.append(String.format("\n%s:\n==============\n\n", group));
            sectionsInGroup.forEach(section -> {
                sb.append(Tmpl01(section));
            });
        });

        sb.append("\n\n***\n\n# Core Function Library (supports the Core extension)\n\n***\n\n");

        sortedcores.forEach((group, sectionsInGroup) -> {
            sb.append(String.format("# %s\n\n", group ));
            //sb.append(String.format("\n%s:\n==============\n\n", group));
            sectionsInGroup.forEach(section -> {
                sb.append(Tmpl01(section));
            });
        });

        Path path = Paths.get("./src/sl_triggers_function_library.md");
        byte[] inbytes = sb.toString().getBytes();

        try {
            Files.write(path, inbytes);
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }

    }

    public static void exportTXT(
        Map<String, List<SltSection>> sortedslts,
        Map<String, List<SltSection>> sortedsexlabs,
        Map<String, List<SltSection>> sortedcores) {
        
        StringBuilder sb = new StringBuilder();

        sb.append("SLT Function Library (baseline functionality always present)\n\n");

        sortedslts.forEach((group, sectionsInGroup) -> {
            //System.out.println("# " + group);
            sb.append(String.format("\n%s:\n==============\n\n", group));
            sectionsInGroup.forEach(section -> {
                sb.append(Tmpl02(section));
            });
        });

        sb.append("\n\n===================================================================================\n\nSexLab Function Library (only functional with SexLab present, contains multiple overrides for SLT behavior)\n\n");

        sortedsexlabs.forEach((group, sectionsInGroup) -> {
            //System.out.println("# " + group);
            sb.append(String.format("\n%s:\n==============\n\n", group));
            sectionsInGroup.forEach(section -> {
                sb.append(Tmpl02(section));
            });
        });

        sb.append("\n\n===================================================================================\n\nCore Function Library (provides functionality for the Core extension)\n\n");

        sortedcores.forEach((group, sectionsInGroup) -> {
            //System.out.println("# " + group);
            sb.append(String.format("\n%s:\n==============\n\n", group));
            sectionsInGroup.forEach(section -> {
                sb.append(Tmpl02(section));
            });
        });

        Path path = Paths.get("./src/sl_triggers_function_library.txt");
        byte[] inbytes = sb.toString().getBytes();

        try {
            Files.write(path, inbytes);
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }

    // Example usage
    public static void main(String[] args) throws IOException {
        
        List<SltSection> slts = parseSltSections("./src/source/scripts/sl_triggersCmdLibSLT.psc");
        List<SltSection> sexlabs = parseSltSections("./src/source/scripts/sl_triggersCmdLibSexLab.psc");
        List<SltSection> cores = parseSltSections("./src/source/scripts/sl_triggersCmdLibCore.psc");

        Map<String, List<SltSection>> sortedslts = sortSltSections(slts);
        Map<String, List<SltSection>> sortedsexlabs = sortSltSections(sexlabs);
        Map<String, List<SltSection>> sortedcores = sortSltSections(cores);
        

        exportMD(sortedslts, sortedsexlabs, sortedcores);
        exportTXT(sortedslts, sortedsexlabs, sortedcores);
    }

    public static String Tmpl01(SltSection section) {
        StringBuilder sb = new StringBuilder();

        sb.append("### ").append(section.name).append("\n\n");
        if (section.desc.size() > 0) {
            sb.append("**Description**\n");
            for (String d : section.desc) {
                sb.append(d).append("\n");
            }
            sb.append("\n");
        }
        if (section.args.size() > 0) {
            sb.append("**Parameters**\n\n");
            for (String a : section.args) {
                sb.append("    ").append(a).append("  \n");
            }
            sb.append("\n");
            if (section.argsmore.size() > 0) {
                for (String am : section.argsmore) {
                    sb.append(am).append("  \n");
                }
                sb.append("\n");
            }
        }
        sb.append("\n");
        if (section.samples.size() > 0) {
            sb.append("**Example**\n\n");
            for (String s : section.samples) {
                sb.append("    ").append(s).append("  \n");
            }
            sb.append("\n");
        }
        if (section.results.size() > 0) {
            for (String r : section.results) {
                sb.append(r).append("  \n");
            }
        }
        sb.append("\n\n");

        return sb.toString();
    }

    public static String Tmpl02(SltSection section) {
        StringBuilder sb = new StringBuilder();

        sb.append(section.name).append(":");
        if (section.desc.size() > 0) {
            sb.append(" ").append(section.desc.get(0));
        }
        sb.append("\n");
        if (section.desc.size() > 1) {
            boolean onepass = true;
            for (String d : section.desc) {
                if (onepass) {
                    onepass = false;
                    continue;
                }
                sb.append(d).append("\n");
            }
        }
        if (section.args.size() > 1) {
            int parmno = 1;
            for (String a : section.args) {
                sb.append(String.format("\t- parameter %d: %s\n", parmno, a));
                parmno++;
            }
            if (section.argsmore.size() > 0) {
                sb.append("\n");
                for (String am : section.argsmore) {
                    sb.append(am).append("\n");
                }
            }
        }
        if (section.samples.size() > 0) {
            sb.append("\n\tExample\n");
            for (String s : section.samples) {
                sb.append(String.format("\t\t%s\n", s));
            }
        }
        if (section.results.size() > 0) {
            sb.append("\n");
            for (String r : section.results) {
                sb.append(String.format("\t%s\n", r));
            }
        }
        sb.append("\n-=-\n\n");

        return sb.toString();
    }

}
