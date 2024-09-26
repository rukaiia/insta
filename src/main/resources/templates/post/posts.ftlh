<#-- posts.ftlh -->
<#import '../layout.ftlh' as layout>
<@layout.layout ; spring>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Все Посты</title>
</head>
<body>
<h1>Все Посты</h1>

<#if posts?has_content>
    <ul>
        <#list posts as post>
            <li>
                <h2>${post.content}</h2>
<#--                <!-- <p>Создано: ${post.createdDate?string("dd-MM-yyyy HH:mm")}</p> &ndash;&gt;-->
                <a href="/posts/${post.user.id}/posts">Посты пользователя</a>
                <#if post.imagePath?has_content>
                    <img src="/uploads/${post.imagePath}" alt="Post Image" style="max-width: 100%; height: auto;">
                <#else>
                    <p>Изображение недоступно</p>
                </#if>
            </li>
        </#list>

    </ul>
<#else>
    <p>Нет постов для отображения.</p>
</#if>


</body>
</html>

</@layout.layout>