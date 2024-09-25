<#-- myposts.ftlh -->
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Мои Посты</title>

</head>
<body>
<h1>Мои Посты</h1>

<#if posts?has_content>
    <ul>
        <#list posts as post>
            <li>
                <h2>${post.content}</h2>
<#--                <p>Создано: ${post.createdDate?string("dd-MM-yyyy HH:mm")}</p>-->
            </li>
        </#list>
    </ul>
<#else>
    <p>У вас пока нет постов.</p>
</#if>
<form action="/posts/create" method="get">
    <button type="submit">Добавить пост</button>
</form>

<a href="/posts">Назад к всем постам</a>
</body>
</html>
