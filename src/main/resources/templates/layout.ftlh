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

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top mb-2">
        <div class="container-fluid">
            <a class="navbar-brand" href="/auth/eduFood">EduFood</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/">Рестораны</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/profile">Профиль</a>
                    </li>
                </ul>
            </div>

            <div class="collapse navbar-collapse justify-content-end">
                <#assign known = SPRING_SECURITY_CONTEXT?? >
                <#if known>
                    <#assign
                    user = SPRING_SECURITY_CONTEXT.authentication.principal
                    name = user.getUsername()
                    >

                    <#if mealsCount?? && mealsCount gt 0>
                        <a href="/cart/view" class="btn btn-outline-info position-relative ms-2 me-2">
                            <i class="bi bi-cart3"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${mealsCount}
                            </span>
                        </a>
                    <#else>
                        <a href="/cart/view" class="btn btn-outline-info position-relative ms-2 me-2">
                            <i class="bi bi-cart3"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                0
                            </span>
                        </a>
                    </#if>

                    <div class="btn-group m-2">
                        <#list user.authorities as auth>
                            <a class="btn-outline-info" href="/profile">
                                ${name}
                            </a>
                            <#if auth?has_next>
                                /
                            </#if>
                        </#list>
                    </div>
                    <#if _csrf??>
                        <form action="/logout" method="post">
                            <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                                   value="${(_csrf.token)!'--no-token--'}"/>
                            <button type="submit" class="btn btn-outline-info m-2" id="logout">Logout</button>
                        </form>
                    <#else>
                        <a href="/logout" class="btn btn-outline-info m-2" id="logout">Logout</a>
                    </#if>
                <#else>
                    <#if mealsCount?? && mealsCount gt 0>
                        <a href="/cart/view" class="btn btn-outline-info position-relative ms-2 me-2">
                            <i class="bi bi-cart3"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${mealsCount}
                            </span>
                        </a>
                    <#else>
                        <a href="/cart/view" class="btn btn-outline-info position-relative ms-2 me-2">
                            <i class="bi bi-cart3"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                0
                            </span>
                        </a>
                    </#if>

                    <a href="/auth/login" class="btn btn-outline-info m-2">Login</a>
                    <a href="/auth/register" class="btn btn-outline-info m-2">Register</a>
                </#if>
            </div>
        </div>
    </nav>

    <div class="container" style="margin-top: 70px;">
        <#nested spring>
    </div>
    <div class="modal fade" id="addToCartModal" tabindex="-1" aria-labelledby="addToCartModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addToCartModalLabel">Спасибо</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Товар успешно добавлен в корзину!
                </div>
                <div class="modal-footer">
                    <a href="/cart/view" class="btn btn-primary">Перейти в корзину</a>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Продолжить покупки</button>
                </div>
            </div>
        </div>
    </div>

    </body>
    </html>
</#macro>