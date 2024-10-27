<#import '../layout.ftlh' as layout>
<@layout.layout ; spring>

    <section class="text-center text-lg-start">
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
                border-radius: 20px;
                backdrop-filter: blur(10px);
            }

            .form-outline {
                margin-bottom: 1.5rem;
            }

            .form-control {
                border-radius: 10px;
                background-color: rgba(255, 255, 255, 0.8);
            }

            .btn-primary {
                transition: background-color 0.3s, transform 0.3s;
                border-radius: 10px;
            }

            .btn-primary:hover {
                background-color: #0b3969;
                transform: scale(1.05);
            }
        </style>

        <div class="card m-3">
            <div class="row g-0 d-flex align-items-center h-100">
                <div class="col-lg-8 mx-auto">
                    <div class="card-body py-5 px-md-3">
                        <h1 class="mb-4">Вход в систему</h1>
                        <form id="login-form" action="/auth/login" method="post">

                            <!-- CSRF -->
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                       value="${(_csrf.token)!'csrf-token'}"/>
                            </#if>

                            <!-- Email input -->
                            <div class="form-outline">
                                <input type="email" id="form2Example1" class="form-control" name="username" required/>
                                <label class="form-label" for="form2Example1">Email адрес</label>
                            </div>

                            <!-- Password input -->
                            <div class="form-outline">
                                <input type="password" id="form2Example2" class="form-control" name="password" required/>
                                <label class="form-label" for="form2Example2">Пароль</label>
                            </div>

                            <!-- Submit button -->
                            <button type="submit" class="btn btn-primary btn-block mb-4">Войти</button>
                            <a href="/auth/forgot_password" class="btn btn-secondary btn-block mb-4">Забыли пароль?</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</@layout.layout>
