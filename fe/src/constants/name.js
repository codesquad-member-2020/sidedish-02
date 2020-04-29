const NAME = (dish) => {
    return {
        PROD: {
            ID: dish.id,
            IMAGE: dish.image,
            ALT: dish.alt,
            DELIVERY_TYPES: dish.deliveryTypes,
            TITLE: dish.title,
            DESCRIPTION: dish.description,
            ORIGINAL_PRICE: dish.originalPrice,
            FINAL_PRICE: dish.finalPrice,
            BADGES: dish.badges
        },

        MOCK: {
            ID: dish.detail_hash,
            IMAGE: dish.image,
            ALT: dish.alt,
            DELIVERY_TYPES: dish.delivery_type,
            TITLE: dish.title,
            DESCRIPTION: dish.description,
            ORIGINAL_PRICE: dish.n_price,
            FINAL_PRICE: dish.s_price,
            BADGES: dish.badge
        }
    }
}

export default NAME