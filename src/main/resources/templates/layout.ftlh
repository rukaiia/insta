
<#import "spring.ftl" as spring>
<#macro layout>
    <!doctype html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <title>Document</title>
    </head>
    <body>
    <style>
        .navbar {
            background-color: whitesmoke;
            backdrop-filter: blur(5px);
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: black;
        }
        .nav-link{
            color: black;
            font-size: 20px;
        }
        .nav-link:hover {
            color: #7a0350;
        }
        .btn-outline-info {
            color: black;
            border-color: black;
        }
        .btn-outline-info:hover {
            color: #FFFFFF;
            background-color: #7a0350;
        }
        .container{
            margin-top: 70px;

        }

    </style>

    <nav class="navbar navbar-expand-lg   fixed-top mb-2">
        <div class="container-fluid">
            <a class="navbar-brand" href="/posts">FUTURE</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/posts/mypost">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/admin/adminpost">Create news</a>
                    </li>

                </ul>
            </div>
            <a href="/news" class="btn btn-outline-info m-3">News</a>

            <#if _csrf??>
                        <form action="/logout" method="post">
                            <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                                   value="${(_csrf.token)!'--no-token--'}"/>
                            <button type="submit" class="btn btn-outline-info m-2" id="logout">Logout</button>
                        </form>
                    <#else>
                        <a href="/logout" class="btn btn-outline-info m-2" id="logout">Logout</a>
                    </#if>




                    <a href="/auth/login" class="btn btn-outline-info m-2">Login</a>
                    <a href="/auth/register" class="btn btn-outline-info m-2">Register</a>

            </div>
        </div>
    </nav>

    <div class="container" style="margin-top: 70px;">
        <#nested spring>
    </div>


    </body>
    </html>
</#macro>