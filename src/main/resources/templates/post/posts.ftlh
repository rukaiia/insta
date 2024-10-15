
<#import '../layout.ftlh' as layout><@layout.layout; spring>
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Все Посты</title>
        <style>
            body {
                background-color: black;
                color: white;
                font-family: Arial, sans-serif;
                margin: 5px;
                padding: 20px;
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
            }
            h1 {
                text-align: center;
                color: #FFD700;
                width: 100%;
                position: relative;
            }
            ul {
                list-style-type: none;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            li {
                border: 1px solid #444;
                border-radius: 10px;
                padding: 10px;
                margin: 20px 0;
                background-color: #222;
                width: 300px;
                max-height: 400px;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            h2 {
                margin: 0 0 5px 0;
                color: #FFD700;
                font-size: 18px;
                text-align: center;
            }
            .description {
                font-size: 14px;
                margin: 20px 0;
                text-align: center;
            }
            img {
                max-width: 100%;
                height: auto;
                border-radius: 5px;
                margin: 10px 0;
            }
            a {
                color: #1E90FF;
                text-decoration: none;
                font-weight: bold;
                text-align: center;
            }
            a:hover {
                text-decoration: underline;
            }
            p {
                margin: 5px 0;
            }




        </style>
    </head>
    <body>
    <h1>Все Посты</h1>
    <#if posts?has_content>
        <ul>
            <#list posts as post>
                <li>
                    <h2>${post.user.email}</h2>
                    <#if post.imagePath?has_content>
                        <img src="/uploads/${post.imagePath}" alt="Post Image">
                    <#else>
                        <p>Изображение недоступно</p>
                    </#if>
                    <p class="description">${post.content}</p>
                    <form action="/posts/${post.id}/like" method="post">
                        <#if _csrf??>
                            <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                   value="${(_csrf.token)!'csrf-token'}"/>
                        </#if>
                        <button type="submit">like</button>
                    </form>
                    <p id="like-count">${post.likeCounts} лайков</p>
                    <a href="/posts/${post.user.id}/posts">Посты пользователя</a>
                </li>
            </#list>
        </ul>
    <#else>
        <p>Нет постов для отображения.</p>
    </#if>
    <script src="/static/js/likeCounts.js"></script>
    </body>
    </html>
</@layout.layout>