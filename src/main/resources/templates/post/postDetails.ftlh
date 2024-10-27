
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Детали Поста</title>
    <style>
        body {
            background-color: #121212;
            color: white;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #FFD700;
        }

        h2, h3 {
            color: #FFD700;
        }

        p {
            font-size: 1.1em;
            margin: 10px 0;
        }

        a {
            color: #1E90FF;
            text-decoration: none;
            font-weight: bold;
            display: block;
            margin: 15px 0;
            text-align: center;
        }

        a:hover {
            text-decoration: underline;
        }

        .container {
            width: 300px;
            max-height: 400px;

            margin: 0 auto;
            padding: 20px;
            border-radius: 10px;
            background-color: #222;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Детали Поста</h1>
    <h2>Контент:</h2>
    <p>${post.content}</p>
    <h3>Создано:</h3>
    <p>${post.createdDate?string("dd-MM-yyyy HH:mm")}</p>
    <h3>Автор поста:</h3>
    <p>${post.user.email}</p>
    <a href="/posts/${post.id}/comments">Посмотреть комментарии</a>
    <a href="/posts">Вернуться к списку постов</a>
</div>
</body>
</html>
