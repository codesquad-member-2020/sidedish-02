import React, { useState, useEffect } from 'react';
import URL from '../constants/url';

const DishDetail = ({ targetId, isOpen, onClose }) => {
    const [targetDish, setTargetDish] = useState([]);
    const [productCount, setProductCount] = useState(0);
    // const [topImage, setTopImage] = useState(targetDish.thumbImages[0]);
    // const [viewDetail, setViewDetail] = useState(true);

    // const onClose = () => {
    //     setViewDetail(false);
    // }

    const fetchInitialData = async () => {
        const targetDishData = await fetchJSON(URL.PROD.DETAIL_API + targetId);
        console.log(targetDishData.description)
        setTargetDish(targetDishData);
    }

    const configureImages = () => {
        // return targetDish.thumbImages.map(img => <img className="thumb-image" src={img} onMouseOver={selectImage}/>) 
        // return Array.from(targetDish.thumbImages).map(img => <img className="thumb-image" src={img} />) 
        // return targetDish.thumbImages.array.map(img => <img className="thumb-image" src={img} />) 
    }

    // const selectImage = () => {
    //     setTopImage()
    // }

    const clickUpButton = () => {
        setProductCount(productCount + 1);
    }

    const clickDownButton = () => {
        (productCount > 0) && setProductCount(productCount - 1);
    }

    useEffect(() => {
        fetchInitialData();
    }, [])

    return (
        <>
        {
        isOpen ?
        <div>
            <div className="dim"></div>
            <div className="detail-popup">
                <div className="image-wrap">
                    <img className="top-image" src={targetDish.topImage} alt={targetDish.alt}/>
                    {/* <img className="top-image" src={topImage} /> */}
                    <div className="thumb-images">
                        {/* {configureImages()} */}
                        {/* {console.log(targetDish.thumbImages)}
                        {console.log(typeof(targetDish.thumbImages))} */}
                        {/* <img className="thumb-image"
                            src={targetDish.thumbImages[0]} /> */}
                        <img className="thumb-image"
                            src="http://public.codesquad.kr/jk/storeapp/data/detail/HBDEF/6ef14155afc5b47e8c9efd762f7a6096.jpg" />
                        <img className="thumb-image"
                            src="http://public.codesquad.kr/jk/storeapp/data/detail/HBDEF/8744504ff3bc315f901dca1f26fe63a1.jpg" />
                        <img className="thumb-image"
                            src="http://public.codesquad.kr/jk/storeapp/data/detail/HBDEF/e30bd6de9340fc05db3cd1d1329b2c56.jpg" />
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
                        <div className="item-final_price">{targetDish.finalPrice}</div>
                    </div>
                    <button className="buy-btn">담기</button>
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
