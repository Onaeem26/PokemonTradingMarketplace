import { useEffect,useState,useCallback } from "react";
import Grid from "@mui/material/Grid";
import React, { Component } from 'react';
import { useParams } from "react-router-dom";
import { useGetDataOne } from "../../../hooks/useGetData";

// Material Kit 2 React components
import MKBox from "components/MKBox";
import MKInput from "components/MKInput";
import MKButton from "components/MKButton";
import MKTypography from "components/MKTypography";

import { getFirestore,collection, getDocs,doc,getDoc ,setDoc,addDoc } from "firebase/firestore"
import { useUserAuth } from "../../../UserAuthContext";


import Popup from 'reactjs-popup';
import 'reactjs-popup/dist/index.css';
import './modal.css'

import DataTable from 'react-data-table-component';

function BidsPage()  {
  const params = useParams();
  const {user} = useUserAuth();
  const[isLoading,setIsLoading] = useState(true)
  const[bidExists,setbidExists] = useState(false)
  const[bgImage,setbgImage]  = useState("")
  const[bidData,setbidData]  = useState([])


  const columns = [
    {
        name: 'Username',
        selector: row => row.username,
    },
    {
        name: 'Price',
        selector: row => row.price,
    },
];

const data = [
    {
        id: 1,
        username: 'user_1',
        price: '25$',
    },
    {
        id: 2,
        username: 'user_2',
        price: '22$',
    },
  ]

  useEffect(async() =>{
    const db = getFirestore();
    const docRef = doc(db, "Cards", params.id);
    const docSnap = await getDoc(docRef);

    if (docSnap.exists()) {
    setbgImage(docSnap.data().images.large)
    setIsLoading(false)
    } else {
    console.log("No such document!");
    }

    const docRef2 = doc(db, "Bids", "bid_"+params.id);
    const docSnap2 = await getDoc(docRef2);

    if (docSnap2.exists()) {
    console.log(docSnap2.data())
    setbidData(docSnap2.data())
    setbidExists(true)
    } else {
    console.log("No such document!");
    }


  },[])

  const handleBid = useCallback(async event => {
    event.preventDefault();
    const { price } = event.target.elements;
    try {
      const db = getFirestore();
      // Add a new document in collection "cities"
      await setDoc(doc(db, "Bids","bid_"+params.id), {
        card_id: params.id,
        user_price: [{user_id:"123456",price:price.value}],
        status: true,
        duration: 10,
      });

    } catch (error) {
      alert(error);
    }
  });

  if(!isLoading){
    return (
      <>
        
        <Grid container spacing={0.5} alignItems="center">
       
          <Grid item xs={12} lg={6}>
            <MKBox
              display={{ xs: "none", lg: "flex" }}
              width="calc(100% - 3rem)"
              height="calc(100vh - 7rem)"
              borderRadius="lg"

              sx={{ backgroundImage: `url(${bgImage})`,backgroundRepeat: 'no-repeat', 
              backgroundPosition: 'center'}}
            />
          </Grid>
          <Grid
            item
            xs={12}
            sm={10}
            md={7}
            lg={6}
            xl={4}
            ml={{ xs: "auto", lg: 6 }}
            mr={{ xs: "auto", lg: 6 }}
          >
            <MKBox
              bgColor="white"
              borderRadius="xxl"
              shadow="lg"
              display="flex"
              flexDirection="column"
              justifyContent="center"
              mt={{ xs: 20, sm: 18, md: 20 }}
              mb={{ xs: 20, sm: 18, md: 20 }}
              mx={0.001}
            >
              <MKBox
                variant="gradient"
                bgColor="info"
                coloredShadow="info"
                borderRadius="lg"
                p={2}
                mx={2}
                mt={-3}
              >
                <MKTypography variant="h3" color="white">
                  Bids
                </MKTypography>
                
              </MKBox>
              <MKBox p={3}>
                <div>
                {bidExists
                    ? <DataTable
                    columns={columns}
                    data={data}
                />
                    : <div>No Data</div>
                  }
                </div>

                <MKBox width="100%" component="form" method="post" autocomplete="off">
                  <Grid container item justifyContent="center" xs={12} mt={5} mb={2}>
                    <Popup
                      trigger={<MKButton variant="gradient" color="info">
                      Place Bid
                    </MKButton>}
                      modal
                      nested
                    >
                      {close => (
                        <div className="modal">
                          <button className="close" onClick={close}>
                            &times;
                          </button>
                          <div className="header"> Place Bid</div>
                          <div className="content">
                          <MKBox component="form" role="form" onSubmit={handleBid}>
                          <MKBox mb={3}>
                            <MKInput name="price" type="price" label="Price" fullWidth />
                          </MKBox>
                          <MKBox mt={4} mb={1}>
                            <MKButton variant="gradient" color="info" type="submit" fullWidth>
                              Place bid
                            </MKButton>
                          </MKBox>
                        </MKBox>
                          </div>
                        </div>
                      )}
                    </Popup>
                  </Grid>
                </MKBox>
              </MKBox>
            </MKBox>
          </Grid>
        </Grid>
      </>
    );
}
else{
  return(
    <div>
    </div>
  )
}
}


export default BidsPage;
