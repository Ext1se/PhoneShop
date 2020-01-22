package com.tpu.shop.data;

public final class Views {
    public interface Id {}

    public interface Base extends Id{}

    public interface User {}

    public interface FullColorModel extends Base {}

    public interface FullModel extends Base {}

    public interface FullSmartPhone extends Base {}

    public interface Comment {}

    public interface Order extends FullSmartPhone {}


}
