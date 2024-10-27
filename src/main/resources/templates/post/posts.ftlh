
<#import '../layout.ftlh' as layout>
<@layout.layout; spring>
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Все Жалобы</title>
        <style>
            body {
                background-color: #ffffff;
                color: #333333;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            h1 {
                color: #0d4d0f;
                font-size: 2.5em;
                margin-bottom: 20px;
                text-align: center;
            }

            .post-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
                max-width: 1200px;
                width: 100%;
            }
            .post-card {
                background-color: #f9f9f9;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 20px;
                width: 30%;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                transition: box-shadow 0.3s ease;
                text-align: center;
            }
            .post-card:hover {
                box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
            }

            h2 {
                color: #195e1c;
                font-size: 1.5em;
                margin: 0 0 10px 0;
            }
            .description {
                font-size: 1em;
                color: #555555;
                margin: 10px 0;
            }
            .district {
                font-size: 2em;
                color: #121212;
                margin: 10px 0;
            }

            img {
                max-width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 8px;
                margin: 15px 0;
            }

            button {
                background-color: #1e5420;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #29672b;
            }

            a {
                color: #0e5211;
                font-weight: bold;
                text-decoration: none;
                display: inline-block;
                margin-top: 10px;
            }
            a:hover {
                text-decoration: underline;
            }
            .pagination {
    margin: 20px 0;
    display: flex;
    justify-content: center;
}

.pagination a {
    margin: 0 5px;
    padding: 5px 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    text-decoration: none;
    color: #333;
}

.pagination span {
    margin: 0 5px;
    padding: 5px 10px;
    background-color: #e0e0e0;
    border-radius: 5px;
}

        </style>
    </head>
    <body>
    <h1>Город будущего</h1>
    <#if posts?has_content>
    <div class="post-container">
        <#list posts as post>
            <div class="post-card">
                <h2>${post.user.email}</h2>
                <#if post.imagePath?has_content>
                    <img src="/uploads/${post.imagePath}" alt="Post Image">
                <#else>
                    <p>Изображение недоступно</p>
                </#if>
                <p class="district">${post.user.district}</p>
                <p class="description">${post.content}</p>

                <form action="/posts/${post.id}/like" method="post">
                    <#if _csrf??>
                        <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}" value="${(_csrf.token)!'csrf-token'}"/>
                    </#if>
                    <button type="submit">👍 Поддержать</button>
                </form>
                <p id="like-count">${post.likeCounts} поддержки</p>
                <a href="/posts/${post.user.id}/posts">Жалобы пользователя</a>
            </div>
        </#list>
    </div>
<#else>
    <p>Нет жалоб для отображения.</p>
</#if>

<#if (currentPage?? && totalPages?? && pageSize??) >
    <div class="pagination">
        <#if (currentPage > 0)>
            <a href="?page=${currentPage - 1}&size=${pageSize}">Предыдущая</a>
        </#if>

        <#list 0..(totalPages - 1) as i>
            <#if i == currentPage>
                <span>${i + 1}</span>
            <#else>
                <a href="?page=${i}&size=${pageSize}">${i + 1}</a>
            </#if>
        </#list>

        <#if currentPage < (totalPages - 1)>
            <a href="?page=${currentPage + 1}&size=${pageSize}">Следующая</a>
        </#if>
    </div>



    <#else>
        <p>Нет жалоб для отображения.</p>
    </#if>


    </body>
    </html>
</@layout.layout>