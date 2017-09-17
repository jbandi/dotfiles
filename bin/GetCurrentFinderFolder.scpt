try
    tell application "Finder"
        set this_folder to (folder of the front window) as alias
    end tell
on error
    set the this_folder to path to desktop folder as alias
end try

set full_path to POSIX path of this_folder
