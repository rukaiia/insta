<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Посты пользователя</title>
    <style>
        body {
            background: linear-gradient(#d9a7c7, #fffcdc);
            color: #333333;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #444444;
            margin-bottom: 20px;
            font-size: 2.5em;
        }

        ul {
            list-style-type: none;
            padding: 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            column-gap: 40px;
            row-gap: 60px;
        }

        li {
            background-color: #F4F4F4;
            border-radius: 10px;
            padding: 20px;
            width: 320px;
            height: 300px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        li:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        }

        h2 {
            margin: 0;
            color: #444444;
            font-size: 1.5em;
            text-align: center;
        }

        img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 5px;
            margin-top: 10px;
        }

        a {
            color: rgba(255, 0, 89, 0.33);
            text-decoration: none;
            font-weight: bold;
            text-align: center;
            margin-top: auto;
        }

        a:hover {
            text-decoration: underline;
        }

        p {
            margin: 5px 0;
            text-align: center;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #000000;
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
                <#if post.imagePath?has_content>
                    <img src="/uploads/${post.imagePath}" alt="Изображение поста">
                <#else>
                    <p>Изображение недоступно</p>
                </#if>
                <p id="like-count">${post.likeCounts} лайков</p>
<#--                <a href="/posts/${post.id}">Посмотреть пост</a>-->
            </li>
        </#list>
    </ul>
<#else>
    <p>У этого пользователя нет постов.</p>
</#if>

<a href="/posts" class="back-link">Назад к всем постам</a>
</body>
</html>


