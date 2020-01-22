<#include "security.ftl">
<#macro login path isRegisterForm>
    <div class="offset-3 col-6 card pt-4 pb-4 mb-4">
        <form action="${path}" method="post" class="col">

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

            <#if isRegisterForm>
            <h4>Регистрация</h4>
            <#else>
                <h4>Вход</h4>
            </#if>

            <div class="form-group mt-3">
                <label>Имя пользователя</label>
                <input type="text" name="username" value="<#if user??>${user.username}</#if>"
                       class="form-control ${(usernameError??)?string('is-invalid', '')}"
                       id="username" maxlength="200" required>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>

            <#if isRegisterForm>
            <div class="form-group">
                <label>Адрес электронной почты</label>
                <input type="email" name="email" value="<#if user??>${user.email}</#if>"
                       class="form-control ${(emailError??)?string('is-invalid', '')}"
                       id="email" maxlength="200" required>
                <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>

            <div class="row">
                <div class="form-group col-6">
                    <label>Имя</label>
                    <input type="text" name="firstName" value="<#if user??>${user.firstName}</#if>"
                           class="form-control ${(firstNameError??)?string('is-invalid', '')}"
                           id="firstName" maxlength="40" required>
                <#if firstNameError??>
                <div class="invalid-feedback">
                    ${firstNameError}
                </div>
                </#if>
                </div>

                <div class="form-group col-6">
                    <label>Фамилия</label>
                    <input type="text" name="lastName" value="<#if user??>${user.lastName}</#if>"
                           class="form-control ${(lastNameError??)?string('is-invalid', '')}"
                           id="lastName" maxlength="40" required>
                <#if lastNameError??>
                <div class="invalid-feedback">
                    ${lastNameError}
                </div>
                </#if>
                </div>
            </div>
            </#if>

            <div class="form-group">
                <label>Пароль</label>
                <input type="password" name="password"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       id="password" required>
                <#if passwordError??>
                <div class="invalid-feedback">
                    ${passwordError}
                </div>
                </#if>
            </div>

            <#if isRegisterForm>
            <div class="form-group">
                <label>Повторите пароль</label>
                <input type="password" name="confirmPassword"
                       class="form-control ${(confirmPasswordError??)?string('is-invalid', '')}"
                       id="confirmPassword" required>
                <#if confirmPasswordError??>
            <div class="invalid-feedback">
                ${confirmPasswordError}
            </div>
                </#if>
            </div>
            </#if>

            <#if !isRegisterForm>
            <div class="form-group">
                <a href="/registration">Создать аккаунт</a>
            </div>
            </#if>

            <button class="btn btn-primary" type="submit">
            <#if isRegisterForm>Зарегистрироваться<#else>Войти</#if>
            </button>

        </form>
    </div>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">
            <#if user??>Выйти<#else>Войти</#if>
        </button>
    </form>
</#macro>