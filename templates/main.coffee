logo =			require './helpers/logo'





module.exports = ($, content = '') ->
	out = '
<!DOCTYPE html>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>' + (if $.group?.name then $.group.name + ' - ' else '') + $.site?.name + '</title>
		<meta name="description" content="' + $.site.description + '">
		<meta name="keywords" content="' + $.site.keywords + '">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<link rel="stylesheet" href="/assets/main.css">
		<link rel="stylesheet" href="/assets/type.css">
		<link rel="stylesheet" href="/assets/forms.css">
		<link rel="stylesheet" href="/assets/icons.css">
	</head>
	<body>
		<main>
			<h1 class="hidden">shout</h1>'
	if $.notices
		out += '
				<div id="notices">'
		for notice in $.notices
			out += '
					<p class="notice ' + notice.type + '">' + notice.text + '</p>'
		out += '
				</div>'
	out += content
	out += '
		</main>
		<footer>
			<a href="/">' + logo() + '</a>
		</footer>
	</body>
</html>'
	return out
