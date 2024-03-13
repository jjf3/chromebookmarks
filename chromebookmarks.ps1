# Define the bookmarks
$bookmarks = @{
    "Google" = "https://www.google.com";
    "Microsoft" = "https://www.microsoft.com";
    "OpenAI" = "https://www.openai.com";
}

# Path to Chrome bookmarks file
$bookmarksFile = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"

# Load existing bookmarks
$existingBookmarks = Get-Content -Path $bookmarksFile | ConvertFrom-Json

# Add new bookmarks
foreach ($name in $bookmarks.Keys) {
    $url = $bookmarks[$name]
    if ($existingBookmarks.roots.bookmark_bar.children.name -notcontains $name) {
        $newBookmark = @{
            "type" = "url"
            "name" = $name
            "url" = $url
        }
        $existingBookmarks.roots.bookmark_bar.children += $newBookmark
    }
}

# Save updated bookmarks
$existingBookmarks | ConvertTo-Json | Set-Content -Path $bookmarksFile

# Restart Chrome to apply changes
Stop-Process -Name "chrome" -Force
Start-Process "chrome"
