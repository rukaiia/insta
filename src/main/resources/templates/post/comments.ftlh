<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Комментарии к посту</title>
</head>
<body>
<h2>${post.content}</h2>
<#if post.imagePath?has_content>
    <img src="/uploads/${post.imagePath}" alt="Post Image" style="max-width: 100%; height: auto;">
<#else>
    <p>Изображение недоступно</p>
</#if>
<p>Создано: ${post.createdDate?string("dd-MM-yyyy HH:mm")}</p>

<h3>Комментарии</h3>
<#if post.comments?has_content>
    <ul>
        <#list post.comments as comment>
            <li>
                <p>${comment.text}</p>
                <p>Создано: ${comment.created?string("dd-MM-yyyy HH:mm")}</p>
            </li>
        </#list>
    </ul>
<#else>
    <p>Комментариев пока нет.</p>
</#if>

<h3>Добавить комментарий</h3>
<form action="/posts/${post.id}/comments" method="post">
    <#if _csrf??>
        <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
               value="${(_csrf.token)!'csrf-token'}"/>
    </#if>
    <label for="content">Контент:</label>
    <textarea name="content" required></textarea>
    <label for="email">Email:</label>
    <input type="email" name="email" required>
    <button type="submit">Добавить комментарий</button>
</form>

<a href="/posts/${post.id}">Назад</a>
</body>
</html>

