<#import '../layout.ftlh' as layout>

<@layout.layout ; spring>
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1511825300125-90c7a78b2e53?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwyMDg4NDB8MHwxfGFsbHwxfHx8fHx8fHwxNjEyMzIzNTI3&ixlib=rb-1.2.1&q=80&w=1080'); /* Замените URL на ваше изображение */
            background-size: cover;
            background-position: center;
            height: 100vh;
            color: #ffffff;
        }

        .card {
            background-color: rgb(11, 79, 37);
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }

        .btn-primary {
            transition: background-color 0.3s, transform 0.3s;
        }

        .btn-primary:hover {
            background-color: #07284b;
            transform: scale(1.05);
        }

        .form-control {
            border-radius: 10px;
        }
        .text-muted{
            color: #250404;

        }
        .d-grid{
            color: darkslategrey;
        }
    </style>

    <div class="container h-100 m-3">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-xl-8 col-md-10">
                <h1 class="text-center mb-4">Регистрация</h1>
                <div class="card shadow-lg p-4">
                    <div class="card-body">
                        <form action="/auth/register" method="post">
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                                       value="${(_csrf.token)!'--no-token--'}"/>
                            </#if>

                            <div class="mb-4">
                                <h6 class="mb-2">Email</h6>
                                <@spring.formInput "userDto.email" 'class="form-control form-control-lg"' />
                                <@spring.showErrors "<br>" "text-danger" />
                            </div>

                            <div class="mb-4">
                                <h6 class="mb-2">Пароль</h6>
                                <@spring.formInput "userDto.password" 'type="password" class="form-control form-control-lg"' />
                                <@spring.showErrors "<br>" "text-danger" />
                            </div>

                            <div class="mb-4">
                                <h6 class="mb-2">Район</h6>
                                <@spring.formInput "userDto.district" 'class="form-control form-control-lg"' />
                                <@spring.showErrors "<br>" "text-danger" />
                            </div>

                            <div class="mb-4">
                                <h6 class="mb-2">Номер телефона</h6>
                                <@spring.formInput "userDto.phoneNumber" 'class="form-control form-control-lg"' />
                                <@spring.showErrors "<br>" "text-danger" />
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">Зарегистрироваться</button>
                            </div>

                        </form>
                    </div>
                </div>
                <div class="text-center mt-4">
                    <p class="text-muted">Уже есть аккаунт? <a href="/auth/login" class="text-light">Войти</a></p>
                </div>
            </div>
        </div>
    </div>
</@layout.layout>
