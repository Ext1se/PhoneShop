package com.tpu.shop.data;

public enum OrderState {
    IDLE("Не активен"),
    PROGRESS("Выполняется"),
    COMPLETED("Завершен"),
    NEGATIVE("Отклонен"),
    POSITIVE("Одобрен");

    private String name;

    OrderState(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
