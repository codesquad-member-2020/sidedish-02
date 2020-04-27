import React, { useState, useEffect } from 'react';
import { css, jsx } from '@emotion/core';
import styled from '@emotion/styled';
import DishWrap from './component/DishWrap';
import URL from './constants/url';

// import './App.css';

const App = () => {
  const [sideDish, setSideDish] = useState([]);
  const [mainDish, setMainDish] = useState([]);
  const [soup, setSoup] = useState([]);
  const [viewAll, setViewAll] = useState(false);

  const fetchInitialData = async () => {
    const initialSideDishData = await fetchJSON(URL.MOCK.SIDE_DISH_API);
    setSideDish(initialSideDishData.body);
    const initialMainDishData = await fetchJSON(URL.MOCK.MAIN_DISH_API);
    setMainDish(initialMainDishData.body);
    const initialSoupData = await fetchJSON(URL.MOCK.SOUP_API);
    setSoup(initialSoupData.body);
  }

  const clickViewAll = () => {
    setViewAll(viewAll ? false : true);
  }

  useEffect(() => {
    fetchInitialData();
  }, [])

  return (
    <>
      <section className="side_dish-wrap">
        <DishWrap dishes={sideDish} category='밑반찬' description='언제 먹어도 든든한' bold='밑반찬' />
      </section>

      <section className="main_dish-wrap">
        <hr class="dish_line" />
        <DishWrap dishes={mainDish} category='메인반찬' description='한그릇 뚝딱' bold='메인 요리' />
      </section>

      <section className="soup-wrap" style={{ display: viewAll ? 'block' : 'none' }}>
        <hr class="dish_line" />
        <DishWrap dishes={soup} category='국&middot;찌개' description='김이 모락모락' bold='국, 찌개' />
      </section>

      <button className="dish-view-all" onClick={clickViewAll}>{viewAll ? '∧' : '∨'}</button>
    </>
  );
}

const fetchJSON = (url) => {
  return fetch(url)
    .then(response => {
      return response.json();
    });
}

export default App;
