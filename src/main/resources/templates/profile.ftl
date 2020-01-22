<#import "parts/common.ftl" as common>

<@common.page true>
<div class="offset-2 col-8 card pt-4 pb-4 mb-4">

    <form action="/user/profile" method="post" class="col">
        <h4>Редактирование профиля</h4>

        <div class="form-group">
            <label>Имя пользователя</label>
            <input type="text" class="form-control" name="username" value="${user.username}" readonly>
        </div>

        <div class="form-group">
            <label>Адрес электронной почты</label>
            <input type="text" class="form-control" name="email" value="${user.email}" required>
        </div>

        <div class="row">
            <div class="form-group col-6">
                <label>Имя</label>
                <input type="text" name="firstName" value="${user.firstName}"
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
                <input type="text" name="lastName" value="${user.lastName}"
                       class="form-control ${(lastNameError??)?string('is-invalid', '')}"
                       id="lastName" maxlength="40" required>
        <#if lastNameError??>
            <div class="invalid-feedback">
                ${lastNameError}
            </div>
        </#if>
            </div>
        </div>

        <div class="form-group">
            <label>Телефон</label>
            <input type="text" class="form-control" name="phoneNumber"
                   value="<#if user.phoneNumber??>${user.phoneNumber}</#if>"
                   placeholder="8-800-555-33-22"
            <#--value="${user.phoneNumber}"-->
            >
        </div>

        <div class="row">
            <div class="form-group col-4">
                <label>Город</label>
                <input type="text" name="address.city"
                       value="<#if user.address??>${user.address.city}</#if>"
                       class="form-control ${(addressCityError??)?string('is-invalid', '')}"
                       id="addressCity" maxlength="40">
            <#if addressError??>
            <div class="invalid-feedback">
                ${addressError}
            </div>
            </#if>
            </div>

            <div class="form-group col-4">
                <label>Улица</label>
                <input type="text" name="address.street"
                       value="<#if user.address??>${user.address.street}</#if>"
                       class="form-control ${(addressStreetError??)?string('is-invalid', '')}"
                       id="addressStreet" maxlength="40">
            </div>

            <div class="form-group col-2">
                <label>Дом</label>
                <input type="text" name="address.house"
                       value="<#if user.address??>${user.address.house}</#if>"
                       class="form-control ${(addressHouseError??)?string('is-invalid', '')}"
                       id="addressHouse" maxlength="40">
            </div>

            <div class="form-group col-2">
                <label>Квартира</label>
                <input type="text" name="address.apartment"
                       value="<#if user.address??>${user.address.apartment}</#if>"
                       class="form-control ${(addressApartmentError??)?string('is-invalid', '')}"
                       id="addressApartment" maxlength="40">
            </div>
        </div>

        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button class="btn btn-primary" type="submit">Сохранить</button>
    </form>
</div>
</@common.page>