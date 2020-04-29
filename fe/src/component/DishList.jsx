import React, { useState } from 'react';
import ModalPortal from '../ModalPortal';
import Slider from "react-slick";
import DishDetail from './DishDetail';
import NAME from '../constants/name';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

const DishList = ({ dishes }) => {
    const DISH = (dish) => NAME(dish).PROD;

    const [targetId, setTargetId] = useState();
    const [viewDetail, setViewDetail] = useState(false);
    // const [prevTargetId, setPrevTargetId] = useState("");

    const openViewDetail = () => {
        setViewDetail(true);
    }

    const closeViewDetail = () => {
        setViewDetail(false);
    }

    const configureBadges = (dish) => {
        return DISH(dish).BADGES ? DISH(dish).BADGES.map(badge => <span className="item-badge">{badge}</span>) : null
    }

    const settings = {
        infinite: true,
        speed: 300,
        slidesToShow: 4,
        slidesToScroll: 4,
        prevArrow: <button type="button" class="slick-prev"></button>,
        nextArrow: <button type="button" class="slick-next"></button>
    };

    const dishList = dishes.map((dish) =>
        <>
            <div className="item" id={DISH(dish).ID} onClickCapture={openViewDetail} onClick={() => setTargetId((DISH(dish).ID))}>
                {viewDetail && (
                    <ModalPortal>
                        <DishDetail targetId={targetId} isOpen={viewDetail} onClose={closeViewDetail} />
                    </ModalPortal>
                )}
                <div className="item-image_box">
                    <img className="item-image" src={DISH(dish).IMAGE} alt={DISH(dish).ALT} />
                    <div className="overlay">
                        <div className="item-delivery_type">
                            <div>{DISH(dish).DELIVERY_TYPES[0]}</div>
                            <hr className="item-delivery_type_line" />
                            <div>{DISH(dish).DELIVERY_TYPES[1]}</div>
                        </div>
                    </div>
                </div>
                <p className="item-title">{DISH(dish).TITLE}</p>
                <p className="item-description">{DISH(dish).DESCRIPTION}</p>
                <div className="item-price">
                    <span className="item-original_price">{DISH(dish).ORIGINAL_PRICE ? DISH(dish).ORIGINAL_PRICE : ''}</span>
                    <span className="item-final_price">{DISH(dish).FINAL_PRICE}</span>
                </div>
                {configureBadges(dish)}
            </div>
        </>
    )

    return (
        <Slider {...settings} className="item-wrap">
            {dishList}
        </Slider>
    )
}

export default DishList