<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Посты пользователя</title>
</head>
<body>
<h1> ${user.email} </h1>

<#if posts?has_content>
    <ul>
        <#list posts as post>
            <li>
                <h2>${post.content}</h2>

                <a href="/posts/${post.id}">Посмотреть пост</a>
                <#if post.imagePath?has_content>
                    <img src="/uploads/${post.imagePath}" alt="Post Image" style="max-width: 100%; height: auto;">
                <#else>
                    <p>Изображение недоступно</p>
                </#if>
            </li>
        </#list>
    </ul>
<#else>
    <p>У этого пользователя нет постов.</p>
</#if>

<a href="/posts">Назад к всем постам</a>

</body>
</html>

