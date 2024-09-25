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
            </li>
        </#list>
    </ul>
<#else>
    <p>У этого пользователя нет постов.</p>
</#if>

<a href="/posts">Назад к всем постам</a>

</body>
</html>

