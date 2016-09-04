# Set editorapp in the workflow environment variables to your preferred editor.
set editorapp to (system attribute "editorapp")

set webUrl to ""
set webTitle to ""
set webSelected to ""

# This expects a browser window to be the front app.
# Invoke alfred while the browser is focused.
tell application "System Events" to set frontApp to name of first process whose frontmost is true

if (frontApp = "Safari") or (frontApp = "Webkit") then
	using terms from application "Safari"
		tell application frontApp
			set webUrl to URL of front document
			set webTitle to name of front document
		end tell
	  end using terms from
else if (frontApp = "Google Chrome") or (frontApp = "Google Chrome Canary") or (frontApp = "Chromium") then
	using terms from application "Google Chrome"
		tell application frontApp
			set webUrl to URL of active tab of front window
			set webTitle to title of active tab of front window
			copy selection of active tab of front window
		end tell
	end using terms from
end if

# Delay to avoid crashing set to the clipboard
delay 1

set webSelected to the clipboard


# Open the template and replace the placeholders with variables.
# Edit template.txt to customize the template.
set pwd to (do shell script "pwd")
set template to pwd & "/template.txt"
set template to (read POSIX file template)
set template to replaceText("{title}", webTitle, template)
set template to replaceText("{url}", webUrl, template)
set template to replaceText("{selection}", webSelected, template)

# Copy the template to the clipboard
set the clipboard to template

# Wake up the editor
tell application editorApp
	reopen
	activate
end tell

# Open a new sheet/note/page and paste the content
tell application "System Events"

	# Most editors use Cmd+n to create a new sheet/note/page.
	keystroke "n" using {command down}

	# Allow time to open.
	delay 1

	# Paste from the clipboard. You might want to use
	# Cmd+v instead of Cmd+Option+v.
	# keystroke "v" using {command down}
	keystroke "v" using {command down, option down}

end tell

on replaceText(find, replace, subject)
	set prevTIDs to text item delimiters of AppleScript
	set text item delimiters of AppleScript to find
	set subject to text items of subject

	set text item delimiters of AppleScript to replace
	set subject to "" & subject
	set text item delimiters of AppleScript to prevTIDs

	return subject
end replaceText