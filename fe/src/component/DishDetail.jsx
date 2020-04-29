import React, { useState, useEffect } from 'react';
import URL from '../constants/url';

const DishDetail = ({ targetId, isOpen, onClose }) => {
    const [targetDish, setTargetDish] = useState({});
    const [productCount, setProductCount] = useState(1);
    const [topImage, setTopImage] = useState();

    const fetchInitialData = async () => {
        const targetDishData = await fetchJSON(URL.PROD.DETAIL_API + targetId);
        setTargetDish(targetDishData);
        setTopImage(targetDishData.thumbImages[0]);
    }

    const configureImages = (images = []) => {
        return images.map(img => <img className="thumb-image" src={img} onMouseOver={() => setTopImage(img)} />)
    }

    const configureDetailImages = (images = []) => {
        return images.map(img => <img className="detail-image" src={img} />)
    }

    const configureTotalPrice = (price = '') => {
        const totalPrice = parseInt(price.replace(',', '').replace('원', '')) * productCount;
        return totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
    }

    const clickUpButton = () => {
        setProductCount(productCount + 1);
    }

    const clickDownButton = () => {
        (productCount > 1) && setProductCount(productCount - 1);
    }

    useEffect(() => {
        fetchInitialData();
    }, [])

    return (
        <>
            {
                isOpen ?
                    <div>
                        <div className="dim" onClick={onClose}></div>
                        <div className="detail-popup">
                            <div className="buy-wrap">
                                <div className="image-wrap">
                                    <img className="top-image" src={topImage} alt={targetDish.alt} />
                                    <div className="thumb-images">
                                        {configureImages(targetDish.thumbImages)}
                                    </div>
                                </div>
                                <div className="product-wrap">
                                    <div className="title">{targetDish.title}</div>
                                    <button className="close-btn" onClick={onClose}>X</button>
                                    <div className="description">{targetDish.description}</div>
                                    <div className="product-point description-wrap">
                                        <div className="description_title">적립금</div>
                                        <div className="description">{targetDish.point}</div>
                                    </div>
                                    <div className="delivery-info description-wrap">
                                        <div className="description_title">배송정보</div>
                                        <div className="description">{targetDish.deliveryInfo}</div>
                                    </div>
                                    <div className="delivery-fee description-wrap">
                                        <div className="description_title">배송비</div>
                                        <div className="description">{targetDish.deliveryFee}</div>
                                    </div>
                                    <div className="item-price">
                                        <span className="item-original_price">{targetDish.originalPrice}</span>
                                        <span className="item-final_price">{targetDish.finalPrice}</span>
                                    </div>
                                    <hr />
                                    <div className="product-count-wrap">
                                        <div className="product-count">수량</div>
                                        <div className="product-count_box-wrap">
                                            <div className="product-count_box">{productCount}</div>
                                            <div className="product-count_button-wrap">
                                                <button className="product-count_button" onClick={clickUpButton}>&#9650;</button>
                                                <button className="product-count_button" onClick={clickDownButton}>&#9660;</button>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div className="total-price">
                                        <div className="total-price_msg">총 상품금액</div>
                                        <div className="item-final_price">{configureTotalPrice(targetDish.finalPrice)}</div>
                                    </div>
                                    <button className="buy-btn">담기</button>
                                </div>
                            </div>
                            <div className="detail-image-wrap">
                                {configureDetailImages(targetDish.detailImages)}
                            </div>
                        </div>
                    </div>
                    :
                    null
            }
        </>
    )
}

const fetchJSON = (url) => {
    return fetch(url)
        .then(response => {
            return response.json();
        });
}

export default DishDetail
