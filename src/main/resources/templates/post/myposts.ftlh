<#-- posts.ftlh -->
<#import '../layout.ftlh' as layout>

<@layout.layout ; spring>
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Мои Посты</title>
    </head>
    <body>
    <h1>Мои Посты</h1>

    <#if posts?has_content>
        <ul>
            <#list posts as post>
                <li>
                    <h2>${post.content}</h2>

                    <form action="/posts/delete" method="post">
                        <#if _csrf??>
                            <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                   value="${(_csrf.token)!'csrf-token'}"/>
                        </#if>

                        <#if post.imagePath?has_content>
                            <img src="/uploads/${post.imagePath}" alt="Post Image" style="max-width: 100%; height: auto;">
                        <#else>
                            <p>Изображение недоступно</p>
                        </#if>
                        <input type="hidden" name="id" value="${post.id}" />
                        <button type="submit">Удалить пост</button>
                    </form>

                    <p>Создано: ${post.createdDate?string("dd-MM-yyyy HH:mm")}</p>
                </li>
            </#list>
        </ul>
    <#else>
        <p>У вас пока нет постов.</p>
    </#if>

    <form action="/posts/create" method="post" enctype="multipart/form-data">
        <#if _csrf??>
            <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                   value="${(_csrf.token)!'csrf-token'}"/>
        </#if>
        <label for="content">Контент:</label>
        <label>
            <textarea name="content" required></textarea>
        </label>
        <label for="image">Выберите изображение:</label>
        <input type="file" name="image" accept="image/*">
        <button type="submit">Добавить пост</button>
    </form>

    <a href="/posts">Назад ко всем постам</a>
    </body>
    </html>
</@layout.layout>