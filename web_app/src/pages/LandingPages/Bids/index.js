import { useEffect,useState,useCallback } from "react";
import Grid from "@mui/material/Grid";
import React from 'react';
import { useParams } from "react-router-dom";

// Material Kit 2 React components
import MKBox from "components/MKBox";
import MKInput from "components/MKInput";
import MKButton from "components/MKButton";
import MKTypography from "components/MKTypography";

import { getFirestore,doc,getDoc ,setDoc } from "firebase/firestore"
import { useUserAuth } from "../../../UserAuthContext";


import Popup from 'reactjs-popup';
import 'reactjs-popup/dist/index.css';
import './modal.css'

import DataTable from 'react-data-table-component';

function BidsPage()  {
  const params = useParams();
  const {user} = useUserAuth();
  const [bidprice, setBidPrice] = useState(0);
  const [isLoading,setIsLoading] = useState(true)
  const [bidExists,setbidExists] = useState(false)
  const [bgImage,setbgImage]  = useState("")

  const[bid_username,setUserName]  = useState("")
  const[bid_price,setPrice]  = useState("")

  const [error, setError] = useState("");


  const columns = [
    {
        name: 'Username',
        selector: row => row.bid_username,
    },
    {
        name: 'Price',
        selector: row => row.bid_price,
    },
  ];

const data = [
    {
        id: 1,
        bid_username: bid_username,
        bid_price: bid_price,
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
    setUserName(user.email)
    setPrice(docSnap2.data().user_price[0].price)
    setbidExists(true)
    } else {
    console.log("No such document!");
    }


  },[])


  const handleBid = async (e) => {
    e.preventDefault();
    setError("");
    console.log(user)
    try {
      const db = getFirestore();
      // Add a new document in collection "cities"
      await setDoc(doc(db, "Bids","bid_"+params.id), {
        card_id: params.id,
        user_price: [{user:user.uid,price:bidprice}],
        status: true,
        duration: 10,
      });
    } catch (err) {
      setError(err.message);
    }
  };

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
                            <MKInput name="bidprice" type="price" label="Price" fullWidth onChange={(e) => setBidPrice(e.target.value)}/>
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
