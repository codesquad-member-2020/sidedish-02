import React, { useState, useEffect } from 'react';
import URL from '../constants/url';

const DishDetail = ({ targetId, onClose }) => {
    const [targetDish, setTargetDish] = useState([]);

    const fetchInitialData = async () => {
        const targetDishData = await fetchJSON(URL.MOCK.DETAIL_API + targetId);
        console.log(targetDishData.data.product_description)
        setTargetDish(targetDishData.data);
    }

    useEffect(() => {
        fetchInitialData();
    }, [])

    return (
        <div>
            <div className="dim"></div>
            <div className="detail-popup">
                <div className="image-wrap">
                    <img className="top-image"
                        src="http://public.codesquad.kr/jk/storeapp/data/detail/HBDEF/4cce011a4a352c22cd399a60271b4921.jpg" alt="" />
                    <div className="thumb-images">
                        <img className="thumb-image"
                            src="http://public.codesquad.kr/jk/storeapp/data/detail/HBDEF/4cce011a4a352c22cd399a60271b4921.jpg" alt="" />
                        <img className="thumb-image"
                            src="http://public.codesquad.kr/jk/storeapp/data/detail/HBDEF/6ef14155afc5b47e8c9efd762f7a6096.jpg" alt="" />
                        <img className="thumb-image"
                            src="http://public.codesquad.kr/jk/storeapp/data/detail/HBDEF/8744504ff3bc315f901dca1f26fe63a1.jpg" alt="" />
                        <img className="thumb-image"
                            src="http://public.codesquad.kr/jk/storeapp/data/detail/HBDEF/e30bd6de9340fc05db3cd1d1329b2c56.jpg" alt="" />
                    </div>
                </div>
                <div className="product-wrap">
                    <div className="title">[소고기] 부드러운 고기</div>
                    <button className="close-btn" onClick={onClose}>X</button>
                    <div className="description">{targetDish.product_description}</div>
                    <div className="product-point description-wrap">
                        <div className="description_title">적립금</div>
                        <div className="description">52원</div>
                    </div>
                    <div className="delivery-info description-wrap">
                        <div className="description_title">배송정보</div>
                        <div className="description">
                            서울 경기 새벽배송 / 전국택배 (제주 및 도서산간 불가) <span className="bold">[월 · 화 · 수 · 목 · 금 · 토]</span> 수령 가능한 상품입니다.</div>
                    </div>
                    <div className="delivery-fee description-wrap">
                        <div className="description_title">배송비</div>
                        <div className="description">
                            2,500원 (<span className="bold">40,000원</span> 이상 구매 시 무료)
          </div>
                    </div>
                    <div className="item-price">
                        <span className="item-original_price">6,500원</span>
                        <span className="item-final_price">5,200원</span>
                    </div>
                    <hr />
                    <div className="product-count-wrap">
                        <div className="product-count">수량</div>
                        <div className="product-count_box-wrap">
                            <div className="product-count_box">0</div>
                            <div className="product-count_button-wrap">
                                <button className="product-count_button">&#9650;</button>
                                <button className="product-count_button">&#9660;</button>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div className="total-price">
                        <div className="total-price_msg">총 상품금액</div>
                        <div className="item-final_price">5,200원</div>
                    </div>
                    <button className="buy-btn">담기</button>
                </div>
            </div>

            {/* {targetId} */}
        </div>

    )
}

const fetchJSON = (url) => {
    return fetch(url)
        .then(response => {
            return response.json();
        });
}

export default DishDetail
