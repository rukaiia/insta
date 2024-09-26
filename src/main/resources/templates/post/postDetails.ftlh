<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Детали Поста</title>
</head>
<body>
<h1>Детали Поста</h1>

<h2>Контент:</h2>
<p>${post.content}</p>

<h3>Создано:</h3>

<h3>Автор поста:</h3>
<p>${post.user.email}</p>
<a href="/posts/${post.id}/comments">Посмотреть комментарии</a>

<a href="/posts">Вернуться к списку постов</a>
</body>
</html>
