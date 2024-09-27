<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Посты пользователя</title>
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

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            border: 1px solid #444;
            border-radius: 5px;
            padding: 15px;
            margin: 10px 0;
            background-color: #222;
        }

        h2 {
            margin: 0 0 10px 0;
            color: #FFD700;
        }

        img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        a {
            color: #1E90FF;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        p {
            margin: 5px 0;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #FFD700;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<h1>${user.email}</h1>

<#if posts?has_content>
    <ul>
        <#list posts as post>
            <li>
                <h2>${post.content}</h2>
                <a href="/posts/${post.id}">Посмотреть пост</a>
                <#if post.imagePath?has_content>
                    <img src="/uploads/${post.imagePath}" alt="Post Image">
                    <p id="like-count">${post.likeCounts} лайков</p>

                <#else>

                    <p>Изображение недоступно</p>
                </#if>
            </li>
        </#list>
    </ul>
<#else>
    <p>У этого пользователя нет постов.</p>
</#if>

<a href="/posts" class="back-link">Назад к всем постам</a>
</body>
</html>

