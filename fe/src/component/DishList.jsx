import React from 'react'

const DishList = ({ dishes }) => {

    const viewDetail = (e) => {
        const tt = e.target.closest("li");
        console.log(tt.id);
    }

    const dishList = dishes.map((dish) =>
        <>
            <li className="item" id={dish.detail_hash} onClick={viewDetail}>
                <div className="item-image_box">
                    <img className="item-image" src={dish.image} alt={dish.alt} />
                    <div className="overlay">
                        <div className="item-delivery_type">
                            <div>{dish.delivery_type[0]}</div>
                            <hr className="item-delivery_type_line" />
                            <div>{dish.delivery_type[1]}</div>
                        </div>
                    </div>
                </div>
                <p className="item-title">{dish.title}</p>
                <p className="item-description">{dish.description}</p>
                <div className="item-price">
                    <span className="item-original_price">{dish.n_price ? dish.n_price : ''}</span>
                    <span className="item-final_price">{dish.s_price}</span>
                </div>
                {dish.badge ? dish.badge.map(b => <span className="item-badge">{b}</span>) : null}
            </li>
        </>
    )

    return (
        <ul className="item-wrap">
            {dishList}
        </ul>
    )
}
export default DishList