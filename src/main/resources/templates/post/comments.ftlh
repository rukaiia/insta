<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Комментарии к посту</title>
</head>
<body>
<h1>Комментарии к посту</h1>

<h2>Пост:</h2>
<p>${post.content}</p>

<h3>Комментарии:</h3>
<ul>
    <#list allComments as comment>
        <li>
            <p>
                <strong>${comment.user.email}</strong>:
                <span>${comment.text}</span>
            </p>
<#--            <p>${comment.created?string("dd-MM-yyyy HH:mm")}</p>-->
        </li>
    </#list>
</ul>


<form action="/comment" method="post">
    <#if _csrf??>
        <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
               value="${(_csrf.token)!'csrf-token'}"/>
    </#if>
    <input type="hidden" name="postId" value="${post.id}" />
    <label>
        <textarea name="comment.content" required></textarea>
    </label>
    <button type="submit">Добавить комментарий</button>
</form>

<a href="/posts/${post.id}">Назад</a>
</body>
</html>
