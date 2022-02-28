// @mui material components
import Container from "@mui/material/Container";
import Grid from "@mui/material/Grid";

// Material Kit 2 React components
import MKBox from "components/MKBox";

// Material Kit 2 React examples
import DefaultInfoCard from "examples/Cards/InfoCards/DefaultInfoCard";
import CenteredBlogCard from "examples/Cards/BlogCards/CenteredBlogCard";

import { useGetData } from "../../../../hooks/useGetData";

function PokCards() {

  const [documents] = useGetData();

  return (
    <MKBox component="section" py={12}>
      <Container>
        <Grid container spacing={5} justifyContent="flex-start">

        {documents.map((documents) => (
          <Grid item xs={12} lg={4} sx={{ ml: "auto", mt: { xs: 3, lg: 0 } }} >
          <CenteredBlogCard
            image={documents.img}
            title={documents.name}
            description="Pokemon"
            action={{
              type: "internal",
              route: "pages/landing-pages/bids/"+documents.id,
              color: "info",
              label: "Buy Now",
            }}
          />
          </Grid>
          ))}
        </Grid>
      </Container>
    </MKBox>
  );
}

export default PokCards;
