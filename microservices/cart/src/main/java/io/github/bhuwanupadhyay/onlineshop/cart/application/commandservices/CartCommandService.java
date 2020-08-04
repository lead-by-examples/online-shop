package io.github.bhuwanupadhyay.onlineshop.cart.application.commandservices;

import io.github.bhuwanupadhyay.onlineshop.cart.domain.model.valueobjects.ShoppingCart;

public interface CartCommandService {

    ShoppingCart updateCart(ShoppingCart cart);

    ShoppingCart findOrUpdateByUserId(String userId);
}