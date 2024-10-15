
<#import '../layout.ftlh' as layout>

<@layout.layout ; spring>
    <div class="container h-100 m-3">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-xl-9">
                <h1 class="text-white mb-4 text-center">Регистрация</h1>
                <div class="card" style="border-radius: 15px;">
                    <div class="card-body">
                        <form action="/auth/register" method="post">

                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                                       value="${(_csrf.token)!'--no-token--'}"/>
                            </#if>

                            <hr class="mx-n3">

                            <div class="row align-items-center py-3">
                                <div class="col-md-3 ps-5">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <div class="col-md-9 pe-5">
                                    <@spring.formInput "userDto.email" 'id="form3Example3cg" class="form-control form-control-lg"' />
                                    <@spring.showErrors  "<br>" "error text-danger" />
                                </div>
                            </div>

                            <hr class="mx-n3">

                            <div class="row align-items-center py-3">
                                <div class="col-md-3 ps-5">
                                    <h6 class="mb-0">Пароль</h6>
                                </div>
                                <div class="col-md-9 pe-5">
                                    <label for="password">Password</label>
                                    <@spring.formInput "userDto.password" 'id="form3Example4cg" class="form-control form-control-lg"' />
                                    <@spring.showErrors "<br>" "error text-danger" />
                                </div>
                            </div>

                            <div class="px-5 py-4">
                                <button type="submit" class="btn btn-primary btn-lg">Зарегистрироваться</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@layout.layout>