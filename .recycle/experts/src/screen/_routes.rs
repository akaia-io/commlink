use {crate::screens::*, dioxus::prelude::*, dioxus_router::prelude::*};

#[derive(Routable, Clone)]
pub enum ExpertsRoute {
	#[route("/")]
	CVScreen {},
}
